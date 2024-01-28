using System.Collections.Generic;
using System.Linq;
using DAL.Models;
using DAL.DataContexts;
using DAL.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace DAL.Repositories
{
    public class TagRepository : ITagRepository
    {
        private readonly RwamoviesContext _context;

        public TagRepository(RwamoviesContext context)
        {
            _context = context;
        }

        public IList<Tag> GetTags()
        {
            return _context.Tags.ToList();
        }

        public Tag GetTag(int id)
        {
            return _context.Tags.FirstOrDefault(t => t.Id == id);
        }

        public IList<Tag> GetTagsForVideo(int videoId)
        {
            return _context.VideoTags
                .Where(vt => vt.VideoId == videoId)
                .Select(vt => vt.Tag)
                .ToList();
        }

        public int InsertTag(Tag tag)
        {
            _context.Tags.Add(tag);
            _context.SaveChanges();
            return tag.Id;
        }

        public void DeleteTag(int id)
        {
            var tag = _context.Tags.Find(id);
            _context.Entry(tag).Collection(t => t.VideoTags).Load();

            if (tag != null)
            {
                try
                {
                    _context.VideoTags.RemoveRange(tag.VideoTags);
                    _context.Tags.Remove(tag);
                    _context.SaveChanges();
                }
                catch (DbUpdateException ex)
                {
                    throw new Exception("Error deleting tag.", ex);
                }
            }
        }



        public void AddTagToVideo(int tagId, int videoId)
        {
            var videoTag = new VideoTag
            {
                TagId = tagId,
                VideoId = videoId
            };

            _context.VideoTags.Add(videoTag);
            _context.SaveChanges();
        }

        public void RemoveTagFromVideo(int tagId, int videoId)
        {
            var videoTag = _context.VideoTags
                .FirstOrDefault(vt => vt.TagId == tagId && vt.VideoId == videoId);

            if (videoTag != null)
            {
                _context.VideoTags.Remove(videoTag);
                _context.SaveChanges();
            }
        }

        public void UpdateTag(int tagId, Tag updatedTag)
        {
            Tag existingTag = _context.Tags.Find(tagId);

            if (existingTag != null)
            {
                existingTag.Name = updatedTag.Name;

                _context.Entry(existingTag).State = EntityState.Modified;

                _context.SaveChanges();
            }
            else
            {
                throw new InvalidOperationException($"Tag with ID {tagId} not found.");
            }
        }
    }
}
